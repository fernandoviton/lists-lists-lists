module Main exposing (..)

import Html exposing ( Html, button, text, h1, div )
import Html.Events exposing (onClick)
import List
import Dict

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model = { 
  rootList : List (Dict.Dict Int {text: String}), 
  nextId : Int
}

model : Model
model =
  { rootList = [ Dict.fromList [(1, {text="hi"})] ], nextId = 2 }


-- UPDATE
type Msg = NewListItem | NewList

update : Msg -> Model -> Model
update msg model = 
  case msg of
    NewListItem -> 
      let 
        firstDict = case List.head model.rootList of
          Just val -> val
          Nothing -> Dict.fromList []
        restDict = case List.tail model.rootList of
          Just val -> val
          Nothing -> []
        newFirstDict = Dict.insert model.nextId {text = "boo"} firstDict
        newRootList = List.append [newFirstDict] restDict
      in { model | rootList = newRootList, nextId = model.nextId + 1}
    NewList -> 
      let 
        newRootList = List.append model.rootList [ Dict.fromList [ (model.nextId, {text="more"}) ] ]
      in { model | rootList = newRootList, nextId = model.nextId + 1 }


-- VIEW
view: Model -> Html Msg
view model =
  div []
    [ button [ onClick NewListItem ] [ text "+item" ]
    , button [ onClick NewList ] [ text "+list" ]
    , text (toString model.rootList)
    ]