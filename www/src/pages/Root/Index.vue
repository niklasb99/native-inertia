<script setup lang="ts">
import {Link} from "@inertiajs/vue3";

let props = defineProps<{
  time: string;
}>();
</script>

<template>
  <header>
  </header>

  <main>
    <h1>Loaded: {{ props.time }}</h1>
    <Link v-for="i in 50" :key="i" :href="`/${i}`">{{ i }}</Link>
  </main>
</template>

<style scoped>
  a{
    display: block;
    margin-bottom: 0.25rem;
  }
</style>
