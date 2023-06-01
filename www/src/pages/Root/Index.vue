<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { router } from '@inertiajs/vue3';

let props = defineProps<{
  degree: number
}>();

const intervalRef = ref<number | undefined>(undefined);

onMounted(() => {
  intervalRef.value = setInterval(() => {
    router.get('/');
  }, 250);
});

onUnmounted(() => clearInterval(intervalRef.value));
</script>

<template>
  <header></header>

  <main>
    <div>{{ -1 * props.degree }}</div>

    <div></div>
    <div class="fixpunkt-top"></div>

    <div class="compass1">
      <img src="../../assets/compass-g0c7a5e191_1280.png" id="compass" :style="`transform: rotate(${props.degree}deg)`">
    </div>
  </main>
</template>








<style scoped>
main {
  display: flex;
  justify-content: center;
}

.fixpunkt-top {
  border: 3px solid black;
  height: 40px;
  width: 0;

  position: absolute;
  top: 80px;
}

.compass1 {
  border: 5px;
  border-color: black;
  border-style: dotted;
  height: 250px;
  width: 250px;
  border-radius: 50%;

  position: absolute;
  top: 150px;

  display: flex;
  justify-content: center;
  align-items: center;
}

img {
  height: 225px;
  width: 225px;
  transition: transform 0.3s ease-in-out;
}
</style>




<!-- <script lang="ts">
import { ref, onMounted, onUnmounted } from "vue";

const degree = ref<number>(0);

const props = {
  degree: Number
};

export { degree, props };

// Weitere Logik und Lifecycle-Hooks können hier folgen
</script>

<script setup lang="ts">
let eventSource: EventSource | null = null;

onMounted(() => {
  eventSource = new EventSource("ws://127.0.0.1:5173");

  eventSource.addEventListener("message", (event: any) => {
    const eventData = JSON.parse(event.data);
    degree.value = eventData.degree;
  });

  eventSource.addEventListener("error", (event: any) => {
    console.error("Error receiving SSE:", event);
  });
});

onUnmounted(() => {
  // Schließe die SSE-Verbindung
  if (eventSource) {
    eventSource.close();
  }
});
</script> -->

