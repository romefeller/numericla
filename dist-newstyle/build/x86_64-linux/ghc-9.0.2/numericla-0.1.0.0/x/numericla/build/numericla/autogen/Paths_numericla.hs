{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_numericla (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/romefeller/.cabal/bin"
libdir     = "/home/romefeller/.cabal/lib/x86_64-linux-ghc-9.0.2/numericla-0.1.0.0-inplace-numericla"
dynlibdir  = "/home/romefeller/.cabal/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/home/romefeller/.cabal/share/x86_64-linux-ghc-9.0.2/numericla-0.1.0.0"
libexecdir = "/home/romefeller/.cabal/libexec/x86_64-linux-ghc-9.0.2/numericla-0.1.0.0"
sysconfdir = "/home/romefeller/.cabal/etc"

getBinDir     = catchIO (getEnv "numericla_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "numericla_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "numericla_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "numericla_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "numericla_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "numericla_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
