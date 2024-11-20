import React from "react";
import CircularProgress from "@mui/material/CircularProgress";
import Box from "@mui/material/Box";
import { Container } from "@mui/material";

function Spinner() {
  return (
    <Container sx={{ display: "flex", justifyContent: "center" }}>
      <Box>
        <CircularProgress />
      </Box>
    </Container>
  );
}

export default Spinner;
