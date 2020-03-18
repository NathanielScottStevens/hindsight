import React from "react"
import { DataDefinitionView } from "../../model/AppView"
import { DataDefinition } from "./DataDefinition"

export interface DataDefinitionListProps {
    readonly definitions: readonly DataDefinitionView[]
}

export const DataDefinitionList = ({definitions}: DataDefinitionListProps) =>
    <>
        {definitions.map(definition => <DataDefinition {...definition}/>)}
    </>
