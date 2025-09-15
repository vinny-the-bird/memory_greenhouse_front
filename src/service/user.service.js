import router from "@/router";
import axios from "axios";

const url = import.meta.env.VITE_API_URL;

export async function getUsers() {
  let info;
  const response = await axios.get(`${url}/users`); // error test
  return (info = response.data);
}

// export async function getUser(id) {
//   const response = await axios.get(`${url}/users/${id}`);
//   const user = response.data;
//   return user;
// };

// export async function getUser(user) {
//   let id = user.id_user;
//   router.push(`/users/${id}`);
// }

export async function getUser(id) {
  const response = await axios.get(`${url}/users/${id}`);
  return response.data[0];
}

export async function openUser(user) {
  let id = user.id_user;
  router.push(`/users/${id}`);
}

export async function createUser(form) {
  const response = await axios.post(`${url}/users`, {
    first_name: form.value.first_name,
    last_name: form.value.last_name,
    password: form.value.password,
  });
  return response.data;
}

export async function updateUser(id, form) {
  const response = await axios.patch(`${url}/users/${id}`, {
    first_name: form.value.first_name,
    last_name: form.value.last_name,
    password: form.value.password,
  });
  return response.data;
}

export async function deleteUser(id) {
  const response = await axios.delete(`${url}/users/${id}`);
  return response.data;
}
