<template>
  <Navbar />
  <div class="container px-2">
    <!-- <div v-if="loading == true">
      <WaitSpinner />
    </div> -->
    <div class="notes">
      <h2 class="title is-4">Notes</h2>

      <nav class="level">
        <div class="level-left">
          <div class="level-item">
            <div class="field has-addons">
              <p class="control">
                <input
                  v-model="searchInput"
                  class="input"
                  type="search"
                  placeholder="Recherche"
                />
              </p>
            </div>
          </div>
        </div>

        <div class="level-right">
          <p class="level-item">
            <a class="button is-success" @click="createNote">
              <font-awesome-icon icon="fa-solid fa-plus" size="1x" />
            </a>
          </p>
        </div>
      </nav>

      <!-- START of cards -->
      <div class="grid is-col-min-16">
        <div
          v-for="paper in filteredPaperNotes"
          :key="paper.id_paper"
          class="cell clickable-row"
          @click="noteService.openThread(paper)"
        >
          <div class="card">
            <div class="card-content">
              <div class="media">
                <div class="media-left">
                  <figure class="image is-48x48">
                    <img
                      src="https://bulma.io/assets/images/placeholders/96x96.png"
                      alt="Placeholder image"
                    />
                  </figure>
                </div>
                <div class="media-content">
                  <div class="title is-5">{{ paper.title }}</div>
                  <div class="subtitle is-5">
                    <time class="is-italic is-size-6">{{ paper.creation_date }}</time>
                    <p>
                      {{ paper.created_by }}
                    </p>
                  </div>
                </div>
              </div>
              <div class="content">
                {{ paper.content }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- END of cards -->
    </div>
  </div>
  <br />
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import Navbar from "@/components/Navbar.vue";
import * as noteService from "@/service/note.service";
import { toastApiError } from "@/service/toast.service";
import router from "@/router";
// import WaitSpinner from "@/components/WaitSpinner.vue";

const searchInput = ref("");
const paperNotes = ref([]);

const filteredPaperNotes = computed(() => {
  const input = searchInput.value?.trim().toLowerCase() || "";

  return paperNotes.value.filter((paperNotes) => {
    const matchesInput = paperNotes.title.toLowerCase().includes(input);

    return matchesInput;
  });
});

function createNote() {
  router.push("/new-note");
}

const loading = ref(false);

onMounted(async () => {
  loading.value = true;
  let error = null;

  Promise.allSettled([noteService.getNotes()]).then((results) => {
    if (results[0].status === "fulfilled") {
      paperNotes.value = results[0].value;
    } else {
      error = results[0].reason;
      toastApiError(error);
    }

    // loading.value = false;
  });
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
