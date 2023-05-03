import { fileURLToPath, URL } from 'node:url'

import path from "path";
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  build: {
    outDir: "../native-inertia-boilerplate/www-dist",
    emptyOutDir: true,
  },
  base: "",
  plugins: [vue()],
  resolve: {
    alias: {
      "@": `${path.resolve(__dirname, "src")}`,
    }
  }
})
