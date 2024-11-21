import { useState, useEffect } from "react";

export default function useGetClients() {
  const [_isLoading, setIsLoading] = useState(true);
  const [clients, setClients] = useState(null);
  const [_Error, setError] = useState(null);

  async function getClients() {
    try {
      const res = await fetch(`/clients`);
      const json = await res.json();
      setClients(json["clients"]);
      setError(null);
    } catch (error) {
      setError(error);
      setClients(null);
    } finally {
      setIsLoading(false);
    }
  }

  useEffect(() => {
    getClients();
  }, []);

  return { clients };
}
