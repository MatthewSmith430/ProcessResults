#' @title htmlreg_convert
#'
#' @description This function converts a .docx file (created using texreg's htmlreg function) to a tabular file (excel or csv)
#' @param doc The .docx file
#' @param excel_format TRUE for excel file, FALSE for a csv
#' @export
#' @return writes the output as a table in excel or csv format.
#'
htmlreg_convert<-function(doc,excel_format){
  NAME1<-gsub(".docx",".xlsx",doc)
  NAME2<-gsub(".docx",".csv",doc)
  complx <- docxtractr::read_docx(doc) #Read .doc created using htmlreg

  TABLE_XLS<-docxtractr::docx_extract_tbl(complx, 1, header=TRUE)

  if (format==TRUE){
    openxlsx::write.xlsx(TABLE_XLS,NAME1)
  }else {readr::write_csv(TABLE_XLS,NAME2)}
}
