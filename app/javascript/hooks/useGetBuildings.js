import { useState, useEffect, useMemo } from "react";

export default function useGetBuildings(page) {
  const [isLoading, setIsLoading] = useState(true);
  const [buildings, setBuildings] = useState(null);
  const [meta, setMeta] = useState(null)
  const [error, setError] = useState(null);

  async function getBuildings(page) {
    try {
      const res = await fetch(`/buildings?page=${page}`);
      const json = await res.json();
      setBuildings(json["buildings"]);
      setMeta(json["meta"])
      setError(null);
    } catch (error) {
      setError(error);
      setBuildings(null);
      setMeta(null)
    } finally {
      setIsLoading(false);
    }
  }

  useEffect(() => {
    getBuildings(page);
  }, [page]);

  return useMemo(
    () => ({ isLoading, buildings, meta, error }),
    [isLoading, buildings, meta, error]
  );
}
