<template>
  <Navbar />

  <div class="container global-frame">
    <h1 class="title is-4">The Longest Day</h1>

    <div class="container">
      <div class="box">
        <h1 class="subtitle is-4">Today is</h1>
        <h1 class="title is-5">{{ today }}</h1>
      </div>
      <div class="box">
        <h1 class="subtitle is-4">Deadline CDA in</h1>
        <h1 class="title is-5">{{ remainingTimeCda }}</h1>
      </div>
      <div class="box">
        <h1 class="subtitle is-4">Final in</h1>
        <h1 class="title is-5">{{ remainingtTimeExam }}</h1>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from "vue";
import Navbar from "@/components/Navbar.vue";

// reactive variables
const today = ref(new Date().toLocaleString());
const remainingTimeCda = ref("");
const remainingtTimeExam = ref("");

// deadlines
const deadlineExam = new Date(2026, 4, 18);
const deadlineCda = new Date(2026, 0, 29);

function formatRemainingTime(ms) {
  const totalSeconds = Math.floor(ms / 1000);
  if (totalSeconds < 0) return "Deadline passed";

  const days = Math.floor(totalSeconds / (3600 * 24));
  const hours = Math.floor((totalSeconds % (3600 * 24)) / 3600);
  const minutes = Math.floor((totalSeconds % 3600) / 60);
  const seconds = totalSeconds % 60;

  const displayedDate = [];
  if (days) displayedDate.push(`${days} day${days !== 1 ? "s" : ""}`);
  if (hours) displayedDate.push(`${hours} hour${hours !== 1 ? "s" : ""}`);
  if (minutes)
    displayedDate.push(`${minutes} minute${minutes !== 1 ? "s" : ""}`);
  if (seconds || displayedDate.length === 0)
    displayedDate.push(`${seconds} second${seconds !== 1 ? "s" : ""}`);

  return displayedDate.join(", ");
}

function updateClock() {
  const now = Date.now();
  today.value = new Date(now).toLocaleString();
  remainingTimeCda.value = formatRemainingTime(deadlineCda - now);
  remainingtTimeExam.value = formatRemainingTime(deadlineExam - now);
}

let intervalId;

onMounted(() => {
  updateClock();
  intervalId = setInterval(updateClock, 1000);
});

onUnmounted(() => {
  clearInterval(intervalId);
});
</script>

<style scoped>
.global-frame {
  padding: 0rem 2rem;
}
</style>
