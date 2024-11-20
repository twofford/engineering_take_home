import { Card } from "@mui/material";
import React from "react";

const BuildingCard = ({ building }) => {
  const {
    address_line_1,
    address_line_2,
    city,
    state,
    zip,
    client: { name },
    custom_fields,
  } = building;
  return (
    <Card>
      <p>{address_line_1}</p>
      <p>{address_line_2}</p>
      <p>{city}</p>
      <p>{state}</p>
      <p>{zip}</p>
      <p>{name}</p>
      {custom_fields.map((el, i) => {
        const data = Object.values(el)[0];
        const key = Object.keys(data)[0];
        const val = Object.values(data)[0];
        return (
          <p key={i}>
            {key}: {val}
          </p>
        );
      })}
    </Card>
  );
};

export default BuildingCard;
