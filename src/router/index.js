import Documentation from "@/views/Documentation.vue";
import Home from "@/views/Home.vue";
import NewUser from "@/views/NewUser.vue";
import Test from "@/views/Test.vue";
import UpdateUser from "@/views/UpdateUser.vue";
import Users from "@/views/Users.vue";
import { createRouter, createWebHistory } from "vue-router";

const routes = [
  { path: "/", name: "Home", component: Home },
  { path: "/users", name: "Users", component: Users },
  { path: "/new-user", name: "New User", component: NewUser },
  { path: "/users/:id", name: "Update User", component: UpdateUser },
  { path: "/documentation", name: "Documentation", component: Documentation },
  { path: "/test", name: "Testlab", component: Test },
];

const router = createRouter({
  history: createWebHistory("/greenhouse/"),
  routes,
});

// router.beforeEach(async (to, from) => {
//   if (!isLogged() && to.name !== "Login") {
//     return { name: "Login" };
//   }
// });

export default router;
