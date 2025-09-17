<template>
  <Navbar />
  <div class="container px-2">
    <h2 class="title is-4">
      Greenhouse Homepage
      <font-awesome-icon icon="fa-solid fa-seedling" />
    </h2>
    <p>As the day goes ..........</p>

    <div class="container is-flex is-align-items-baseline">
      <!-- X-factor sizing -->

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" />
        <p class="text is-italic is-justify-content-center">1x</p>
      </div>

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" size="2x" />
        <p class="text is-italic is-justify-content-center">2x</p>
      </div>

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" size="3x" />
        <p class="text is-italic is-justify-content-center">3x</p>
      </div>

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" size="4x" />
        <p class="text is-italic is-justify-content-center">4x</p>
      </div>

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" size="5x" />
        <p class="text is-italic is-justify-content-center">5x</p>
      </div>

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" size="6x" />
        <p class="text is-italic is-justify-content-center">6x</p>
      </div>

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" size="7x" />
        <p class="text is-italic is-justify-content-center">7x</p>
      </div>

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" size="8x" />
        <p class="text is-italic is-justify-content-center">8x</p>
      </div>

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" size="9x" />
        <p class="text is-italic is-justify-content-center">9x</p>
      </div>

      <div
        class="container is-flex is-flex-direction-column is-align-items-center"
      >
        <font-awesome-icon icon="fa-solid fa-coffee" size="10x" />
        <p>10x</p>
      </div>
    </div>
    <br />
    <p class="is-italic">Font Awesome sizes (normal to 10x)</p>
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
