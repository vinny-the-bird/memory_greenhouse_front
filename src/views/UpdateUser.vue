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
                    v-model="inputFirstName"
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
                v-model="inputLastName"
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
            <label class="label">Prévision du nom d'utilisateur</label>
            <p v-if="!inputFirstName && !inputLastName"></p>
            <p class="has-text-weight-bold is-lowercase has-text-centered" v-else>"{{  username }}"</p>
          </div>


            <div class="field">
                <label class="label">Mot de passe</label>
                <div class="control">
            <input
                class="input"
                type="password"
                v-model="form.password"
                placeholder="Mot de passe"
                required
                ></input>
            </div>
        </div>
        </div>
    </div>
            <!-- </div> -->


      

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
                  :disabled="!form.name || !form.client || !form.environment"
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
import Navbar from "@/components/Navbar.vue";
import router from "@/router";
// import { getProductsAndEnvironments } from "@/service/products-and-environment.service";
// import * as receiverService from "@/service/receiver.service";
// import * as clientService from "@/service/client.service";
import { useRoute } from "vue-router";
import { toast } from "vue3-toastify";
import { toastApiError } from "@/service/toast.service";
import "vue3-toastify/dist/index.css";
import ConfirmationModal from "@/components/ConfirmationModal.vue";
// import WaitSpinner from "@/components/WaitSpinner.vue";
import * as userService from "@/service/user.service";


const route = useRoute();
const id = route.params.id;
// const clients = ref([]);
// const environments = ref([]);
// const receiver = ref([]);
const user = ref([]);

const inputFirstName = ref("");
const inputLastName = ref("");
const loading = ref(false);

const modalTitle = "Confirmer la suppression ?";
const modalButtonName = "Supprimer";
const modalConfirmButtonName = "Oui";
const modalCancelButtonName = "Retour";

const form = ref({
  first_name: inputFirstName,
  last_name: inputLastName,
  password: "",
});

async function updateUser() {
  await userService
    .updateUser(id, form)

    .then((response) => {
      router.push("/users");

      setTimeout(() => {
        toast("Utilisateur édité avec succès !", {
          theme: "colored",
          type: "success",
          position: "bottom-center",
        });
      }, 100);
    })
    .catch((err) => {
      toast(message, {
        theme: "colored",
        type: "error",
        position: "bottom-center",
      });
    });
}

async function deleteUser() {
  await userService
    .deleteUser(id)
    .then((response) => {
      router.push("/users");

      setTimeout(() => {
        toast("Utilisateur supprimé avec succès !", {
          theme: "colored",
          type: "success",
          position: "bottom-center",
        });
      }, 100);
    })
    .catch((err) => {
      toast(message, {
        theme: "colored",
        type: "error",
        position: "bottom-center",
      });
    });
}

onMounted(async () => {
  loading.value = true;
  let error = null;

  Promise.allSettled([
    userService.getUser(id),
    // getProductsAndEnvironments(),
    // clientService.getClients(),
  ])
    .then((results) => {
      if (results[0].status === "fulfilled") {
        user.value = results[0].value;
      } else {
        error = results[0].reason;
        toastApiError(error);
      }

    //   loading.value = false;
    })
    .then(() => {
      form.value = {
        first_name: user.value.firstName,
        last_name: user.value.lastName,
        password: user.value.password,
      };
      // loading.value = false;
    });
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
