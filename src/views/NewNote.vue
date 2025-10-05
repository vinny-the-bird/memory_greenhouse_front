<template>
  <Navbar />
  <div class="container px-2">
    <div class="container mt-5">
      <div class="box">
        <h1 class="title is-4">Poster une nouvelle note</h1>
        <form @submit.prevent>
          <!-- User dropdown -->

          <div class="field">
            <label class="label">Utilisateur</label>
            <div class="control">
              <div class="select is-fullwidth">
                <select v-model="form.created_by" required>
                  <option disabled value="">
                    -- Choisir un utilisateur --
                  </option>
                  <option
                    v-for="u in users"
                    :key="u.id_user"
                    :value="u.id_user"
                  >
                    {{ u.first_name }} {{ u.last_name }}
                  </option>
                </select>
              </div>
            </div>
          </div>

          <!-- Title input -->
          <div class="field">
            <label class="label">Titre</label>
            <div class="control">
              <input
                class="input"
                type="text"
                v-model="form.title"
                placeholder="Votre titre"
                required
              />
            </div>
          </div>

          <!-- Content textarea -->
          <div class="field">
            <label class="label">Contenu</label>
            <div class="control">
              <textarea
                class="textarea"
                v-model="form.content"
                placeholder="Votre texte"
                required
              ></textarea>
            </div>
          </div>

          <!-- Buttons -->
          <div class="level">
            <div class="level-left"></div>
            <div class="level-right">
              <button
                class="button is-primary"
                type="submit"
                :disabled="!form.title || !form.content"
                @click="createNote"
              >
                Enregistrer
              </button>
              <a class="button is-light" @click="router.go(-1)">Retour</a>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import Navbar from "@/components/Navbar.vue";
import router from "@/router";
import * as noteService from "@/service/note.service";
import * as userService from "@/service/user.service";
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";

function getLocalDateTimeString() {
  const now = new Date();

  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, "0");
  const day = String(now.getDate()).padStart(2, "0");
  const hours = String(now.getHours()).padStart(2, "0");
  const minutes = String(now.getMinutes()).padStart(2, "0");
  const seconds = String(now.getSeconds()).padStart(2, "0");

  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

// TODO: replace hardcoded user id (mvp: dropdown?)
// const currentUser = 84;

// all users list
const users = ref([]);

onMounted(async () => {
  users.value = await userService.getUsers();
});

const form = ref({
  title: "",
  content: "",
  creation_date: getLocalDateTimeString(),
  created_by: null,
});

async function createNote() {
  if (!form.value.created_by) {
    toast("Veuillez sélectionner un utilisateur", {
      theme: "colored",
      type: "warning",
      position: "bottom-center",
    });
    return;
  }

  await noteService
    .createNote(form)

    .then((response) => {
      router.push("/notes");

      setTimeout(() => {
        toast("Note créée avec succès !", {
          theme: "colored",
          type: "success",
          position: "bottom-center",
        });
      }, 100);
    })
    .catch((err) => {
      toast(err, {
        theme: "colored",
        type: "error",
        position: "bottom-center",
      });
    });
}
</script>

<style scoped></style>
