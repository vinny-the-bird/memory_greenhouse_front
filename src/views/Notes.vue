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
            <a class="button is-success" @click="createUser">
              <font-awesome-icon icon="fa-solid fa-plus" size="1x" />
            </a>
          </p>
        </div>
      </nav>

      <table class="table is-hoverable has-text-left is-fullwidth">
        <thead>
          <tr class="">
            <th>Titre</th>
            <th>Contenu</th>
            <th>Auteur</th>
            <th>Date</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="paper in filteredPaperNotes"
            :key="paper.id_paper"
            class="clickable-row"
            @click="noteService.openThread(paper)"
          >
            <td>
              {{ paper.title }}
            </td>
            <td>{{ paper.content }}</td>
            <td>{{ paper.created_by }}</td>
            <td>{{ paper.creation_date }}</td>
          </tr>
        </tbody>
      </table>
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

function createUser() {
  router.push("/new-user");
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
</style>
