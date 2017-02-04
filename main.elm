module Main exposing (..)

import Html exposing ( Html, button, text, h1, div, p )
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
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
    [ newListItemButton
    , rootList model.rootList
    , newListButton
    ]

rootList :  List (Dict.Dict Int { text : String }) -> Html Msg
rootList list =
  Html.ul
  []
  (List.map (\d -> div [] [listSeperator, innerList d]) list)

listSeperator : Html Msg
listSeperator =
  Html.h2 [] [text "list"]

innerList : (Dict.Dict Int { text : String }) -> Html Msg
innerList dict = 
  Html.ul
  []
  (List.map (\a -> (listItem a)) (Dict.values dict))

listItem : {text : String} -> Html Msg
listItem item =
  Html.li [] [text item.text]

newListButton : Html Msg
newListButton =
  button
    [ style
      buttonStyle
   , onClick NewList
   ] [text "+ list"]

newListItemButton : Html Msg
newListItemButton =
  button
    [ style
      buttonStyle
   , onClick NewListItem
   ] [text "+ item"]

buttonStyle = [
  ("textAlignment","center")
  , ("backgroundColor","#4C9689")
  , ("color","white")
  , ("fontSize","18px")
  , ("padding","10")
  , ("borderRadius","5")
  , ("border","none")
  , ("ontFamily", "Tahoma, Verdana, Segoe, sans-serif")
  , ("border-radius", ".25em")
  , ("vertical-align", "baseline")
  ]

buttonStyleOld = [
  ("font-size", "32px")
  , ("margin", "auto")
  , ("display", "block")
  , ("display", "inline-block")
  , ("zoom", "1")
  , ("*display", "inline")
  , ("vertical-align", "baseline")
  , ("margin", "0 2px")
  , ("outline", "none")
  , ("cursor", "pointer")
  , ("text-align", "center")
  , ("text-decoration", "none")
  , ("font", "14px/100% Arial, Helvetica, sans-serif")
  , ("padding", ".5em 2em .55em")
  , ("text-shadow", "0 1px 1px rgba (0,0,0,.3)")
  , ("-webkit-border-radius", ".5em") 
  , ("-moz-border-radius", ".5em")
  , ("border-radius", ".5em")
  , ("-webkit-box-shadow", "0 1px 2px rgba (0,0,0,.2)")
  , ("-moz-box-shadow", "0 1px 2px rgba (0,0,0,.2)")
  , ("box-shadow", "0 1px 2px rgba(0,0,0,.2)") 
  ]