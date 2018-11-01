module Main where

import Network
import System.IO
import Text.Printf

server = "chat.freenode.net"
port = 6667
chan = "#rammytest"
nick = "rammy"

main :: IO ()
main = do
  handle <- connectTo server (PortNumber port)
  hSetBuffering handle NoBuffering
  write handle "NICK" nick
  write handle "USER" $ nick ++ " 0 * :rammy bot"
  write handle "JOIN" chan
  listen handle

write :: Handle -> String -> String -> IO ()
write h s1 s2 =
  hPrintf h "%s %s\r\n" s1 s2 *> printf "> %s %s\n" s1 s2

listen :: Handle -> IO ()
listen h =
  let forever a = a *> forever a
  in forever (hGetLine h >>= putStrLn)
