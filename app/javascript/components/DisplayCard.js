import React from "react";
import { Card, CardContent, CardActions } from "@mui/material";
import { Button } from "@mui/material";
import CustomField from "./CustomField";

const DisplayCard = ({ building, toggleFunction }) => {
  const {
    address_line_1,
    address_line_2,
    city,
    state,
    zip,
    client: { name },
    custom_fields,
  } = building;

  const handleOnClick = () => {
    toggleFunction();
  };

  return (
    <Card>
      <CardContent>
        <p>
          <strong>Address:</strong> {address_line_1}, {address_line_2}
        </p>
        <p>
          <strong>City:</strong> {city}
        </p>
        <p>
          <strong>State:</strong> {state}
        </p>
        <p>
          <strong>ZIP:</strong> {zip}
        </p>
        <p>
          <strong>Client:</strong> {name}
        </p>
        <p>
          {custom_fields.map((el, i) => {
            return <CustomField key={i} el={el} isEditView={false}/>;
          })}
        </p>
      </CardContent>
      <CardActions style={{ display: "flex", justifyContent: "center" }}>
        <Button variant="contained" onClick={() => handleOnClick()}>
          Edit
        </Button>
      </CardActions>
    </Card>
  );
};

export default DisplayCard;
