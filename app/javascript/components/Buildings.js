import React from "react";
import { Container, Stack } from "@mui/material";
import BuildingCard from "./BuildingCard";

const Buildings = ({ buildings }) => {
  return (
    <Container>
      <Stack direction="row" spacing={5}>
        {buildings &&
          buildings.map((building, i) => {
            return <BuildingCard building={building} key={i} />;
          })}
      </Stack>
    </Container>
  );
};

export default Buildings;
