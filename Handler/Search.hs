{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Search where

import Import

data Result = Result
  { resultTitle :: Text }

getSearchR :: Handler Html
getSearchR = do
    ((formRes, searchWidget), _) <- runFormGet searchForm
    searchResults <-
      case formRes of
        FormSuccess qstring -> getResults qstring
        _ -> return []
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "Searching for Stutors"
        $(widgetFile "search")

searchForm :: Html -> MForm Handler (FormResult Text, Widget)
searchForm = renderDivs $ areq (searchField True) "Search" Nothing

getResults::Text -> Handler [Result]
getResults qstring = return [ Result {resultTitle="Joe Brown"}, Result {resultTitle="Jessica Simpson"} ]
