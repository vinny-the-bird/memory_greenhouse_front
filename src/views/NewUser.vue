<template>
  <Navbar />
  <div class="container px-2">
    <div class="container mt-5">
      <div class="box">
        <h1 class="title is-4">Créer un utilisateur</h1>
        <form @submit.prevent>
          <div class="columns is-vcentered">
            <div class="column is-half">

              <div class="field">
                <label class="label">Prénom</label>
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
            <label class="label">Nom</label>
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


          <div class="level">
            <div class="level-left"></div>
            <div class="level-right">
              <div class="control level-item">
                <button
                  class="button is-primary"
                  type="submit"
                  :disabled="!form.first_name || !form.last_name || !form.password"
                  @click="createUser"
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
import { ref, computed } from "vue";
import Navbar from "@/components/Navbar.vue";
import router from "@/router";
// import * as channelService from "@/service/channel.service";
import * as userService from "@/service/user.service";
// import { getProductsAndEnvironments } from "@/service/products-and-environment.service";
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";

const inputFirstName = ref("");
const inputLastName = ref("");

const username = computed(() => {
  const first = inputFirstName.value.replace(/\s+/g, "").toLowerCase();
  const last = inputLastName.value.replace(/\s+/g, "").toLowerCase();
  if (!first && !last) return "";
  return `${first}_${last}`;
});

// const form = ref({
//   first_name: "",
//   last_name: "",
//   password: "",
// });

const form = ref({
  first_name: inputFirstName,
  last_name: inputLastName,
  password: "",
});

async function createUser() {
  await userService
    .createUser(form)

    .then((response) => {
      router.push("/users");

      setTimeout(() => {
        toast("Utilisateur créé avec succès !", {
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

// TODO: forbid special chars BUT allow all types of accents
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
  const isLowerAlpha = /^[a-z ]$/i.test(e.key);

  if (!isLowerAlpha && !allowedKeys.includes(e.key)) {
    e.preventDefault();
  }
}

function handlePaste(e) {
  const text = e.clipboardData.getData("text");
  if (!/^[a-z ]+$/i
.test(text)) {
    e.preventDefault();
  }
}

// onMounted(async () => {
//   let info = await getProductsAndEnvironments();
//   products.value = info.products;
//   environments.value = info.environments;
// });
</script>

<style scoped>

/* .low {
    text-transform: lowercase;
} */

/* .center {
  text-align: center;
} */

.field {
    /* background-color: aqua; */
    height: 5rem;
}

</style>