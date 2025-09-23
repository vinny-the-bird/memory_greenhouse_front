<template>
  <Navbar />
  <div class="container px-2">
    <!-- <div v-if="loading == true">
      <WaitSpinner />
    </div> -->
    <div class="users">
      <h2 class="title is-4">temp - notes</h2>

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
            <th>Prénom</th>
            <th>Nom</th>
            <th>Nom d'utilisateur</th>
            <th>N° tag</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="user in filteredUsers"
            :key="user.id_user"
            class="clickable-row"
            @click="userService.openUser(user)"
          >
            <td>
              {{ user.first_name }}
            </td>
            <td>{{ user.last_name }}</td>
            <td>{{ user.username }}</td>
            <td>{{ user.id_tag }}</td>
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
import * as userService from "@/service/user.service";
import { toastApiError } from "@/service/toast.service";
import router from "@/router";
// import WaitSpinner from "@/components/WaitSpinner.vue";

const searchInput = ref("");
const users = ref([]);

const filteredUsers = computed(() => {
  const input = searchInput.value?.trim().toLowerCase() || "";

  return users.value.filter((users) => {
    const matchesInput = users.username.toLowerCase().includes(input);

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

  Promise.allSettled([
    userService.getUsers(),
  ]).then((results) => {
    if (results[0].status === "fulfilled") {
      users.value = results[0].value;
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
