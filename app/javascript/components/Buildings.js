import React from "react";
import { Container, Stack } from "@mui/material";
import BuildingCard from "./BuildingCard";

const Buildings = ({ buildings }) => {
  return (
    <Stack direction="row" spacing={2}>
      {buildings &&
        buildings.map((building, i) => {
          return <BuildingCard building={building} key={i} />;
        })}
    </Stack>
  );
};

export default Buildings;
