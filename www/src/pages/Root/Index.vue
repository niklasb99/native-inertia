<script setup lang="ts">
import { router } from '@inertiajs/vue3';
import {Link} from "@inertiajs/vue3";

let props = defineProps<{
  userName: string;
  data?: {
    highestExpense: string;
    numberOfCategories: number;
    numberOfItems: number;
    lastAddedExpense: string;
    categoryWithMostExpenses: string;
    total: string;
  };
}>();

function getData() {
  router.get('/overview');
}

function fakeResponse() {
  window.dispatchEvent(new CustomEvent('native-inertia', {
    detail: {
      "component": "App",
      "props": { "errors": {}, "welcome": "Hello again!" },
      "url": "\/",
    }
  }));
}
</script>

<template>
  <header>
  </header>

  <main>
    <h1 class="font-bold text-2xl">{{ props.userName }}</h1>
    <div class="flex gap-3">
      <button class="text-white bg-indigo-500 hover:bg-indigo-600 px-3 py-2 rounded-md" @click="getData">Get
        Data!</button>
      <button class="text-white bg-indigo-500 hover:bg-indigo-600 px-3 py-2 rounded-md" @click="fakeResponse">Fake
        Response</button>
      <Link class="text-white bg-indigo-500 hover:bg-indigo-600 px-3 py-2 rounded-md" href="/expenses">Expenses</Link>

      <Link class="text-white bg-indigo-500 hover:bg-indigo-600 px-3 py-2 rounded-md" href="/categories">Categories</Link>
    </div>
    <ul v-if="props.data && props.data.numberOfItems > 0">
      <li> Highest Expense: {{ props.data.highestExpense }} </li>
      <li> Number of Categories: {{ props.data.numberOfCategories }} </li>
      <li> Number of Items: {{ props.data.numberOfItems }} </li>
      <li> Last added Expense: {{ props.data.lastAddedExpense }} </li>
      <li> Category with most expenses: {{ props.data.categoryWithMostExpenses }} </li>
      <li> Total: {{ props.data.total }} </li>
    </ul>
    <div v-else>
      Du hast noch keine Daten. :(
    </div>
  </main>
</template>

<style scoped>

</style>
