<template>
  <div class="sticky-navbar">
    <nav class="navbar is-dark" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <router-link class="navbar-item" to="/">
          <img
            class="image"
            src="/src/assets/sprout.png"
            alt="Greenhouse Logo"
          />
        </router-link>

        <!-- <a
          role="button"
          class="navbar-burger"
          aria-label="menu"
          aria-expanded="false"
          data-target="navbarBasicExample"
        >
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a> -->
      </div>

      <div id="navbarBasicExample" class="navbar-menu">
        <div class="navbar-start">
          <router-link class="navbar-item" to="/">Home</router-link>
          <router-link class="navbar-item" to="/notes">Notes</router-link>
          <router-link class="navbar-item" to="/users">Utilisateurs</router-link>
          <router-link class="navbar-item" to="/documentation"
            >Documentation</router-link
          >
          <!-- <router-link class="navbar-item" to="/test">TEST LAB</router-link> -->
        </div>

        <div class="navbar-end">
          <!-- Affiche les URL de l'API (utile pour debug) -->
          <!-- <div class="navbar-item">
            <span
              :title="apiInfo"
              class="has-text-info is-size-4"
              style="cursor: help"
            >
              <span class="icon">
                <font-awesome-icon icon="fa-solid fa-circle-info" />
              </span>
            </span>
          </div> -->

          <div class="navbar-item">
            <div class="buttons">
              <button
                class="button logout is-danger is-outlined"
                @click="onLogout()"
              >
                <span class="icon">
                  <font-awesome-icon icon="fa-solid fa-right-from-bracket" />
                </span>
                <span>Déconnexion</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </nav>
    <br />
  </div>
</template>

<script setup>
import { ref } from "vue";

const apiInfo = ref(
  `API :      ${import.meta.env.VITE_API_URL}\nLogin :   ${
    import.meta.env.VITE_LOGIN_URL
  }`
);

</script>

<style scoped>
/* img.image {
  margin-left: 1.5rem;
  margin-right: 1.5rem;
  width: 9rem;
} */

.sticky-navbar {
  position: sticky;
  top: 0;
  z-index: 100;
}

.logout {
  color: white;
}

.logout:hover {
  background-color: rgb(241, 38, 38);
}
</style>
