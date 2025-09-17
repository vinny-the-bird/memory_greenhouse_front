<template>
  <Navbar />
  <div class="container px-2">
    <!-- <div v-if="loading == true">
      <WaitSpinner />
    </div> -->
    <div class="container mt-5">
      <div class="box">
        <h1 class="title is-4">Éditer un utilisateur</h1>
        <form @submit.prevent>
          <div class="columns is-vcentered">
      
            <div class="column is-half">

              <div class="field">
                <label class="label">Prénom(s)</label>
                <div class="control">
                  <input
                    class="input is-capitalized"
                    type="text"
                    v-model="form.first_name"
                    placeholder="Prénom"
                    @keydown="blockInvalidInput"
                    @paste="handlePaste"
                    required
                  />
                </div>
              </div>


            <div class="field">
            <label class="label">Nom(s)</label>
            <div class="control">
              <input
                class="input is-capitalized"
                type="text"
                v-model="form.last_name"
                placeholder="Nom"
                @keydown="blockInvalidInput"
                @paste="handlePaste"
                required
              ></input>
            </div>
          </div>
            </div>
        
            <div class="column is-half">
            <div class="field">
            <label class="label">Prévision nom d'utilisateur auto-généré</label>
            <div class="control">
              <input
                class="input"
                type="text"
                v-model="username"
                placeholder="Nom d'utilisateur"
                @keydown="blockInvalidInput"
                @paste="handlePaste"
                readonly
              ></input>
            </div>
          </div>

            <div class="field">
                <label class="label">Mot de passe</label>
                <div class="control">
            <input
                class="input"
                type="password"
                v-model="form.password"
                placeholder="Mot de passe"
                disabled
                ></input>
            </div>
        </div>
        </div>
    </div>


          <div class="level">
            <div class="level-left">
              <div class="control level-item">
                <ConfirmationModal
                  :title="modalTitle"
                  :modalButtonName="modalButtonName"
                  :primaryButtonName="modalConfirmButtonName"
                  :secondaryButtonName="modalCancelButtonName"
                  @click="deleteUser"
                />
              </div>
            </div>

            <div class="level-right">
              <div class="control level-item">
                <button
                  class="button is-primary"
                  type="submit"
                  :disabled="!form.first_name || !form.last_name || !form.password"
                  @click="updateUser"
                >
                  Enregistrer
                </button>
              </div>

              <div class="control level-item">
                <a class="button is-light" @click="router.go(-1)">Retour</a>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>

import { ref, onMounted, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { toast } from "vue3-toastify";
import { toastApiError } from "@/service/toast.service";
import * as userService from "@/service/user.service";
import Navbar from "@/components/Navbar.vue";
import ConfirmationModal from "@/components/ConfirmationModal.vue";

const route = useRoute();
const router = useRouter();
const id = route.params.id;

const user = ref(null);
const loading = ref(false);
const message = "Erreur lors de la mise à jour";

const modalTitle = "Confirmer la suppression ?";
const modalButtonName = "Supprimer";
const modalConfirmButtonName = "Oui";
const modalCancelButtonName = "Retour";

const form = ref({
  first_name: "",
  last_name: "",
  password: "",
});

const username = computed(() => {
  const first = streamlineName(form.value.first_name);
  const last = streamlineName(form.value.last_name);
  if (!first && !last) return "";
  return `${first}_${last}`;
});

function streamlineName(string) {
  return string
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[\s'-]/g, "")
    .toLowerCase();
}

async function updateUser() {
  try {
    await userService.updateUser(id, {
      ...form.value,
      username: username.value,
    });

    router.push("/users");

    setTimeout(() => {
      toast("Utilisateur édité avec succès !", {
        theme: "colored",
        type: "success",
        position: "bottom-center",
      });
    }, 100);
  } catch (err) {
    toast(message, {
      theme: "colored",
      type: "error",
      position: "bottom-center",
    });
  }
}

async function deleteUser() {
  try {
    await userService.deleteUser(id);
    router.push("/users");

    setTimeout(() => {
      toast("Utilisateur supprimé avec succès !", {
        theme: "colored",
        type: "success",
        position: "bottom-center",
      });
    }, 100);
  } catch (err) {
    toast(message, {
      theme: "colored",
      type: "error",
      position: "bottom-center",
    });
  }
}

onMounted(async () => {
  loading.value = true;

  try {
    user.value = await userService.getUser(id);

    form.value.first_name = user.value.first_name;
    form.value.last_name = user.value.last_name;
    form.value.password = user.value.password; 
  } catch (err) {
    toastApiError(err);
  } finally {
    loading.value = false;
  }
});


function blockInvalidInput(e) {
  const allowedKeys = [
    "Backspace",
    "Tab",
    "ArrowLeft",
    "ArrowRight",
    "ArrowUp",
    "ArrowDown",
    "Delete",
  ];
  const isLowerAlpha = /^[\p{L}' -]+$/u.test(e.key);

  if (!isLowerAlpha && !allowedKeys.includes(e.key)) {
    e.preventDefault();
  }
}

function handlePaste(e) {
  const text = e.clipboardData.getData("text");
  if (!/^[\p{L}' -]+$/u
.test(text)) {
    e.preventDefault();
    alert("Seuls les lettres, avec ou sans accent, les tirets, les apostrophes et les espaces sont autorisés.");
  }
}

</script>
