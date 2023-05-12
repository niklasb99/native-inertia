<script setup lang="ts">
import {Link} from "@inertiajs/vue3";

let props = defineProps<{
  time: number;
}>();
</script>

<template>
  <header>
  </header>

  <main>
    <h2>Loaded: {{ props.time }}</h2>
    <Link v-for="i in 3" :key="i" :href="`/${i}`">{{ i }}</Link>
  </main>
</template>

<style scoped>
  a{
    display: block;
    margin-bottom: 0.25rem;
  }
</style>
