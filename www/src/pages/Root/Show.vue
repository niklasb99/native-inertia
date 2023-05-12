<script setup lang="ts">
import { Link } from "@inertiajs/vue3";
import { defineProps } from "vue";

let props = defineProps<{
  time: string;
  id: string;
}>();

let startTime: number;
let stopTime: number;

const startTimer = () => {
  startTime = Date.now();
  localStorage.setItem("startTime", String(startTime));
};

const stopTimer = () => {
  const storedStartTime = localStorage.getItem("startTime");
  if (storedStartTime) {
    startTime = parseInt(storedStartTime); // In localstorage strings are stored- conversion of the string into a number
    stopTime = Date.now();
    const duration = stopTime - startTime;
    console.log("Starttime:", startTime);
    console.log("Stoptime:", stopTime);
    console.log(`%c Duration: ${duration} ms`, 'color: green');
  }

  localStorage.removeItem("startTime");
};

stopTimer();
</script>

<template>
  <header>
  </header>

  <main>
    <Link v-for="i in 3" :key="i" :href="`/${i}`" @click="startTimer">Seite {{ i }}</Link>
    <h2 class="font-bold text-2xl">Current page: {{ props.id }}</h2>
    <h3>Loaded at: {{ props.time }}</h3>
  </main>
</template>

<style scoped>
main {
  padding-top: 20px;
}

a {
  all: unset;
  background-color: #0369a1;
  border-radius: 4px;
  color: white;
  display: inline-block;
  margin-right: 5px;
  padding: 12px 24px;
}
</style>

