import React, { useState } from "react";
import { Container, Pagination } from "@mui/material";
import useGetBuildings from "../hooks/useGetBuildings";
import Buildings from "./Buildings";
import Spinner from "./Spinner";

const App = () => {
  const [page, setPage] = useState(1);
  const { isLoading, buildings, meta, error } = useGetBuildings(page);

  const handleOnChange = (_, v) => {
    setPage(v);
  };

  if (isLoading) {
    return (
      <Container>
        <Spinner />
      </Container>
    );
  } else {
    return (
      <Container>
        <Buildings isLoading={isLoading} buildings={buildings} error={error} />
        <Pagination
          count={meta["total"] / 5}
          page={page}
          onChange={handleOnChange}
        />
      </Container>
    );
  }
};

export default App;
