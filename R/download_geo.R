#' Download and Extract GEO Datasets
#'
#' @param geo_accession A character vector of GEO accession numbers (e.g., "GSE233906").
#' @param dest_dir The directory where files will be downloaded and extracted.
#' @return Invisible NULL. Files are downloaded and extracted into the specified directory.
#' @export
download_geo <- function(geo_accession, dest_dir = "geo.data") {
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
  }

  for (accession in geo_accession) {
    geo_url <- paste0("https://ftp.ncbi.nlm.nih.gov/geo/series/",
                      substr(accession, 1, nchar(accession) - 3), "nnn/",
                      accession, "/suppl/", accession, "_RAW.tar")
    tar_file <- file.path(dest_dir, paste0(accession, "_RAW.tar"))

    message("Downloading ", accession, " from GEO...")
    utils::download.file(geo_url, tar_file, mode = "wb")

    message("Extracting ", accession, "...")
    utils::untar(tar_file, exdir = dest_dir)

    file.remove(tar_file)
  }

  invisible(NULL)
}
