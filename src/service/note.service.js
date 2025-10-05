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
  return response.data;
}

export async function openThread(paper) {
  let id = paper.id_paper;
  router.push(`/threads/${id}`);
}

export async function createNote(form) {
  const f = form.value ?? form;

  const payload = {
    paper_type: "note",
    title: f.title,
    content: f.content,
    parent_id: null,
    creation_date: f.creation_date,
    created_by: f.created_by,
  };

  const response = await axios.post(`${url}/papers`, payload, {
    headers: { "Content-Type": "application/json" },
  });
  return response.data;
}


/**
 * Create a comment (child paper) for a note or another comment.
 * Expects `form` to be either a reactive ref or a plain object containing:
 * { content, creation_date, created_by, parent_id, title? }
 */
export async function createComment(form) {
  const f = form.value ?? form;

  const payload = {
    paper_type: "comment",
    title: f.title ?? null,
    content: f.content,
    parent_id: f.parent_id ?? null,
    creation_date: f.creation_date,
    created_by: f.created_by,
  };

  const response = await axios.post(`${url}/papers`, payload, {
    headers: { "Content-Type": "application/json" },
  });
  return response.data;
}

