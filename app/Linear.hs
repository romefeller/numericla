module Linear where

import Numeric.LinearAlgebra.Data
import Numeric.LinearAlgebra
import qualified Data.ByteString.Lazy as BS
import Data.Csv.HMatrix
import Data.Csv.Incremental
import Graphics.Gnuplot.Simple
import Prelude hiding ((<>))

mat :: Matrix Double
mat = (3><3) [2, 4, 7, -3, 11, 0, 1, 3, 5]

mat' :: Matrix Double
mat' = (3><2) [4, 7, 11, 0, 3, 5]

ler :: FilePath -> IO (Matrix Double)
ler file = fmap (decodeMatrix HasHeader)  (BS.readFile file)
-- m :: 8618 x 38
-- m^t :: 38 x 8618
-- m^t <> m :: 38x38

mtm :: FilePath -> IO (Matrix Double)
mtm file = fmap (\m -> tr m <> m)  (ler file)

autos :: FilePath -> IO (Vector (Complex Double), Matrix (Complex Double))
autos file = fmap eig (mtm file)

avet :: FilePath -> IO (Matrix (Complex Double))
avet file = fmap (\m -> takeColumns 2 m)  (fmap snd (autos file))

nuvem :: FilePath -> IO [(Double,Double)]
nuvem path = fmap (fmap (\[x,y] -> (x,y))) (fmap toLists (fmap (\m -> takeColumns 2 m) (ler path)))

plotar :: IO ()
plotar = do
  pontos <- nuvem "data/nndb_flatM.csv"
  plotList [Custom ] pontos

pca :: IO [Double]
pca = do
        ls <- fmap toList (fmap fst (autos "data/nndb_flatM.csv"))
        todosLs <- return (fmap realPart ls)
        return (fmap (\l -> 100 * l / sum todosLs) todosLs)





