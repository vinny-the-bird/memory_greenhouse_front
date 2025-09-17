<template>
  <Navbar />
  <div class="container px-2">
    <h2 class="title is-4">Documentation</h2>

    <div
      class="container is-flex is-flex-direction-column is-align-items-center"
    >
      <img
        src="\src\assets\yang_silicon_valley.jpg"
        alt="A cool photo of Jimmy Yang for the show 'Silicon Valley'"
        width="60%"
      />

      <p class="text is-italic is-justify-content-center">"The what?"</p>
    </div>
  </div>
</template>

<script setup>
import Navbar from "@/components/Navbar.vue";
</script>

<style scoped>
.px-2 {
  margin-bottom: 3rem;
}
</style>
