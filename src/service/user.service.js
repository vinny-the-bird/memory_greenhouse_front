import router from "@/router";
import axios from "axios";

const url = import.meta.env.VITE_API_URL;

export async function getUsers() {
  let info;
  const response = await axios.get(`${url}/users`); // error test
  return (info = response.data);
};

export async function getUser(id) {

};

export async function createUser(form) {

};

export async function updateUser(id, form) {

};

export async function deleteUser(id) {

};