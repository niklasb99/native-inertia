<script setup lang="ts">
import {Link} from "@inertiajs/vue3";

let props = defineProps<{
  id: number;
}>();
</script>

<template>
  <header>
  </header>

  <main>
    <h1 class="font-bold text-2xl">{{ props.id }}</h1>
    <Link href="/">Index</Link>
  </main>
</template>

<style scoped>

</style>