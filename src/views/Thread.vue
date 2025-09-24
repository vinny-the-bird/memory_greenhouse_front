<template>
  <Navbar />
  <div class="container px-2">
    <!-- <div v-if="loading == true">
      <WaitSpinner />
    </div> -->
    <div class="notes">
      <h2 class="title is-4">{{ thisThread.title }}</h2>

      <!-- START of media object -->

      <article class="media">
  <figure class="media-left">
    <p class="image is-64x64">
      <img src="https://bulma.io/assets/images/placeholders/128x128.png" />
    </p>
  </figure>
  <div class="media-content">
    <div class="content">
      <p>
        <strong>{{ thisThread.created_by }}</strong> <small> {{ thisThread.creation_date }}</small>
        <br />
                {{ thisThread.content }}
      </p>
    </div>
    <nav class="level is-mobile">
      <div class="level-left">
        <a class="level-item">
        <font-awesome-icon icon="fa-solid fa-reply" />
        </a>
        <a class="level-item">
            <font-awesome-icon icon="fa-solid fa-thumbs-up" />
        </a>
        <a class="level-item">
            <font-awesome-icon icon="fa-solid fa-thumbs-down" />
        </a>
      </div>
    </nav>
  </div>
</article>

      <!-- END of media object -->
    </div>
  </div>
  <br />
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import Navbar from "@/components/Navbar.vue";
import * as noteService from "@/service/note.service";
import { toastApiError } from "@/service/toast.service";

const route = useRoute();
const id = route.params.id;

const paper = ref(null);

const thisThread = ref({
  title: "",
  creation_date: "",
  created_by: "",
  content: "",
});

onMounted(async () => {

  try {
    paper.value = await noteService.getThread(id);

    thisThread.value.title = paper.value.title;
    thisThread.value.creation_date = paper.value.creation_date;
    thisThread.value.created_by = paper.value.created_by;
    thisThread.value.content = paper.value.content;

  } catch (err) {
    toastApiError(err);
  } finally {
    loading.value = false;
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
