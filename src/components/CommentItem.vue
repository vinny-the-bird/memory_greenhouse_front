<template>
  <div class="comment-item box" :style="{ marginLeft: levelOffset + 'px' }">
    <article class="media">
      <figure class="media-left">
        <p class="image is-48x48">
          <img src="https://bulma.io/assets/images/placeholders/96x96.png" />
        </p>
      </figure>

      <div class="media-content">
        <div class="content">
          <p>
            <strong>{{ comment.created_by }}</strong
            ><br />
            <small class="is-italic is-size-7">{{
              comment.creation_date
            }}</small
            ><br />
            {{ comment.content }}
          </p>
        </div>

        <nav class="level is-mobile">
          <div class="level-left">
            <a class="level-item" @click.prevent="toggleReply">
              <font-awesome-icon icon="fa-solid fa-reply" />&nbsp;
            </a>
            <a class="level-item">
              <font-awesome-icon icon="fa-solid fa-thumbs-up" />
            </a>
            <a class="level-item">
              <font-awesome-icon icon="fa-solid fa-thumbs-down" />
            </a>
          </div>
        </nav>

        <!-- reply form for this comment -->
        <div v-if="showReply" class="box">
          <form @submit.prevent="submitReply">
            <!-- user dropdown -->
            <div class="field">
              <label class="label">Utilisateur</label>
              <div class="control">
                <div class="select is-fullwidth">
                  <select v-model="replyForm.created_by" required>
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
                  v-model="replyForm.content"
                  rows="3"
                  placeholder="Écrire une réponse..."
                  required
                ></textarea>
              </div>
            </div>

            <div class="level">
              <div class="level-left"></div>
              <div class="level-right">
                <button
                  class="button is-primary"
                  type="submit"
                  :disabled="!replyForm.content || !replyForm.created_by"
                >
                  Répondre
                </button>
                <a class="button is-light" @click="cancelReply">Annuler</a>
              </div>
            </div>
          </form>
        </div>

        <!-- recursive nested comments -->
        <div
          v-if="comment.comments && comment.comments.length"
          class="children-comments"
        >
          <CommentItem
            v-for="child in comment.comments"
            :key="child.id_paper"
            :comment="child"
            :level="level + 1"
            :users="props.users"
            @posted="onChildPosted"
          />
        </div>
      </div>
    </article>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";
import CommentItem from "./CommentItem.vue"; // recursive import
import * as noteService from "@/service/note.service";
import { toastApiError } from "@/service/toast.service";

// ✅ removed local fetching; rely only on parent-provided users
const props = defineProps({
  comment: { type: Object, required: true },
  level: { type: Number, default: 0 },
  users: { type: Array, default: () => [] },
});

const emit = defineEmits(["posted"]);

const levelOffset = computed(() => props.level * 12);
const showReply = ref(false);

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

const replyForm = ref({
  content: "",
  creation_date: getLocalDateTimeString(),
  created_by: null,
  parent_id: props.comment.id_paper,
});

function toggleReply() {
  showReply.value = !showReply.value;
}

function cancelReply() {
  showReply.value = false;
  replyForm.value.content = "";
}

async function submitReply() {
  try {
    replyForm.value.creation_date = getLocalDateTimeString();
    replyForm.value.parent_id = props.comment.id_paper;

    await noteService.createComment(replyForm);

    // reset form and close
    replyForm.value.content = "";
    showReply.value = false;

    // notify parent thread to refresh
    emit("posted");
  } catch (err) {
    toastApiError(err);
  }
}

function onChildPosted() {
  emit("posted");
}
</script>

<style scoped>
.comment-item {
  margin-bottom: 0.75rem;
  padding: 0.5rem;
}
.children-comments {
  margin-top: 0.5rem;
}
</style>
