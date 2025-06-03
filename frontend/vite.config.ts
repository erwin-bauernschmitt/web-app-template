import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";

export default defineConfig({
  plugins: [react()],
  ////// EDIT {
  server: {
    host: "0.0.0.0",  // Bind to all network interfaces
    port: 3000,  // Set dev server port explicitly
    // HTTPS support using env vars for key/cert paths (optional)
    https: process.env.VITE_HTTPS_KEY && process.env.VITE_HTTPS_CERT
      ? {
          key: process.env.VITE_HTTPS_KEY,
          cert: process.env.VITE_HTTPS_CERT,
        } as any  // Type assertion due to env var string inputs
      : undefined, 
  },
  ////// }
});
