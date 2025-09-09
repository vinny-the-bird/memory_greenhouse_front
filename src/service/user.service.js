// import router from "@/router";²
import axios from "axios";

const url = import.meta.env.VITE_API_URL;

export async function getUsers() {
  let info;
  const response = await axios.get(`${url}/users`); // error test
  return (info = response.data);
};

export async function getUser(id) {
  const response = await axios.get(`${url}/users/${id}`);
  const user = response.data;
  return user;
};

export async function displayUser(user) {
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
};

export async function updateUser(id, form) {

};

export async function deleteUser(id) {

};