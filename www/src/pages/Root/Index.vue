<script setup lang="ts">
import { router } from "@inertiajs/vue3";

let takePicture = () => {
  router.get("/takePicture");
}

document.addEventListener("visibilitychange", () => {
  if (document.visibilityState === "visible") {
    location.reload()
  } 
});
</script>

<template>
  <header>
  </header>

  <main>
    <h1>MOIN</h1>
    <button @click="takePicture">Take a picture!</button>
  </main>
</template>

<style scoped>
  a{
    display: block;
    margin-bottom: 0.25rem;
  }
</style>