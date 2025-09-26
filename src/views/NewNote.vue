<template>
  <Navbar />
  <div class="container px-2">
    <div class="container mt-5">
      <div class="box">
        <h1 class="title is-4">Poster une nouvelle note</h1>
        <form @submit.prevent>
          <div class="">
            <div class="">

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

            </div>
            <div class="field">
            <label class="label">Contenu </label>
            <div class="control">
              <input
                class="input"
                type="textarea"
                v-model="form.content"
                placeholder="Votre texte"
                required
              ></input>
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
                  :disabled="!form.title || !form.content"
                  @click="createNote"
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
import * as noteService from "@/service/note.service";
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
const currentUser = 84;

const form = ref({
  title: "",
  content: "",
  creation_date: getLocalDateTimeString(),
  created_by: currentUser,
});


async function createNote() {
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

<style scoped>

.field {
    /* background-color: aqua; */
    height: 5rem;
}

</style>