// import './assets/main.css'

import { createApp } from "vue";
import App from "./App.vue";
import router from "@/router";

const app = createApp(App);
app.use(router);

app.config.errorHandler = (err, vm, info) => {
  console.error("Error:", err);
  console.error("Vue component:", vm);
  console.error("Additional info:", info);
};
app.mount("#app");
