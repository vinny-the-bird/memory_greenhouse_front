<template>
  <Navbar />
  <div class="container px-2">
    <div class="notes">
      <h2 class="title is-4">{{ thisThread.title }}</h2>

      <article class="media">
        <figure class="media-left">
          <p class="image is-64x64">
            <img
              src="https://bulma.io/assets/images/placeholders/128x128.png"
            />
          </p>
        </figure>

        <div class="media-content">
          <div class="content">
            <p>
              <strong>{{ thisThread.created_by }}</strong>
              <small>{{ thisThread.creation_date }}</small
              ><br />
              {{ thisThread.content }}
            </p>
          </div>

          <nav class="level is-mobile">
            <div class="level-left">
              <a class="level-item" @click.prevent="toggleReplyToNote">
                <font-awesome-icon icon="fa-solid fa-reply" />
              </a>
              <!-- <a class="level-item">
                <font-awesome-icon icon="fa-solid fa-thumbs-up" />
              </a>
              <a class="level-item">
                <font-awesome-icon icon="fa-solid fa-thumbs-down" />
              </a> -->
            </div>
          </nav>
         
          <div v-if="showReplyToNote" class="box">
            <form @submit.prevent="submitReplyToNote">
              <div class="field">
                <label class="label">Utilisateur</label>
                <div class="control">
                  <div class="select is-fullwidth">
                    <select v-model="replyToNoteForm.created_by" required>
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

              <div class="field">
                <div class="control">
                  <textarea
                    class="textarea"
                    v-model="replyToNoteForm.content"
                    rows="3"
                    placeholder="Écrire un commentaire..."
                    required
                  ></textarea>
                </div>
              </div>


              <div class="level">
                <div class="level-left"></div>
                <div class="level-right">
                  <div class="buttons">
                    <button
                      class="button is-primary"
                      type="submit"
                      :disabled="
                        !replyToNoteForm.content || !replyToNoteForm.created_by
                      "
                    >
                      Poster
                    </button>
                    <a class="button is-light" @click="cancelReplyToNote"
                      >Annuler</a
                    >
                  </div>
                </div>
              </div>
            </form>
          </div>
  
          <div v-if="thisThread.comments && thisThread.comments.length">
            <CommentItem
              v-for="c in thisThread.comments"
              :key="c.id_paper"
              :comment="c"
              :level="0"
              :users="users"
              @posted="refreshThread"
            />
          </div>
        </div>
      </article>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import Navbar from "@/components/Navbar.vue";
import CommentItem from "@/components/CommentItem.vue";
import * as noteService from "@/service/note.service";
import * as userService from "@/service/user.service";
import { toastApiError } from "@/service/toast.service";

const route = useRoute();
const id = route.params.id;

const thisThread = ref({
  title: "",
  creation_date: "",
  created_by: "",
  content: "",
  comments: [],
});

const users = ref([]);

const showReplyToNote = ref(false);
const replyToNoteForm = ref({
  content: "",
  created_by: null,
  creation_date: "",
  parent_id: id,
});

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

function toggleReplyToNote() {
  showReplyToNote.value = !showReplyToNote.value;
}

function cancelReplyToNote() {
  showReplyToNote.value = false;
  replyToNoteForm.value.content = "";
  replyToNoteForm.value.created_by = null;
}

async function submitReplyToNote() {
  try {
    replyToNoteForm.value.creation_date = getLocalDateTimeString();
    replyToNoteForm.value.parent_id = id;

    await noteService.createComment(replyToNoteForm);

    // reset
    showReplyToNote.value = false;
    replyToNoteForm.value.content = "";
    replyToNoteForm.value.created_by = null;

    // refresh
    await refreshThread();
  } catch (err) {
    toastApiError(err);
  }
}

async function refreshThread() {
  try {
    const res = await noteService.getThread(id);
    thisThread.value = res;
  } catch (err) {
    toastApiError(err);
  }
}

onMounted(async () => {
  try {
    // fetch thread and all users
    const [threadRes, usersRes] = await Promise.all([
      noteService.getThread(id),
      userService.getUsers(),
    ]);
    thisThread.value = threadRes;
    users.value = usersRes;
  } catch (err) {
    toastApiError(err);
  }
});
</script>

<style scoped>
.clickable-row {
  cursor: pointer;
}
.px-2 {
  margin-bottom: 3rem;
}
.content {
  padding: 0.5rem;
}
.card {
  margin-top: 2rem;
}
</style>
