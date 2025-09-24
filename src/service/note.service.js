import router from "@/router";
import axios from "axios";

const url = import.meta.env.VITE_API_URL;

export async function getNotes() {
  let info;
  const response = await axios.get(`${url}/threads`);
  return (info = response.data);
}

export async function getThread(id) {
  const response = await axios.get(`${url}/threads/${id}`);
  console.log("🚀 ~ getThread ~ response.data:", response.data)
  
  return response.data;
}

export async function openThread(paper) {
  let id = paper.id_paper;
  // console.log("🚀 ~ openThread ~ paper:", paper)
  // console.log("🚀 ~ openThread ~ id:", id)
  router.push(`/threads/${id}`);
}

export async function createUser(form) {
  const response = await axios.post(`${url}/users`, {
    first_name: form.first_name,
    last_name: form.last_name,
    username: form.username,
    password: form.password,
  });
  return response.data;
}

export async function updateUser(id, form) {
  const response = await axios.patch(`${url}/users/${id}`, {
    first_name: form.first_name,
    last_name: form.last_name,
    username: form.username,
    password: form.password,
  });
  return response.data;
}

export async function deleteUser(id) {
  const response = await axios.delete(`${url}/users/${id}`);
  return response.data;
}
