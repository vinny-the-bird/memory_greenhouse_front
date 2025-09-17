import * as toastify from "vue3-toastify";
import "vue3-toastify/dist/index.css";


export async function toastApiError(error, duration = 1500) {

  console.error("Error:", error);

  let message = "Erreur du serveur distant";

  if (error.status === 400) {
    message = "Requête erronée";
  } else if (error.status === 401) {
    message = "Erreur d'identification";
  } else if (error.status === 403) {
    message = "Accès interdit";
  } else if (error.status === 404) {
    message = "La ressource n'a pas été trouvée";
  } else if (error.status === 418) {
    message = "Je suis une 🫖";
  } else if (error.code === 'ERR_NETWORK') {
    message = "Serveur distant inaccessible.\nRefus de connexion de sécurisée ou hors ligne"
  }
  setTimeout(() => {
    toastify.toast(message, {
      theme: "colored",
      type: "error",
      position: "bottom-center",
      autoClose: duration
    });
  })
}


export async function toastSuccess(message, duration = 700) {

  setTimeout(() => {
    toastify.toast(message, {
      theme: "colored",
      type: "success",
      position: "bottom-center",
      autoClose: 700
    })
  })
}