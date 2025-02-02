#' A combination of all summary statistics function and data management function
#'
#' This function gives a table 1
#'
#' @param dat your cohort data file, of \code{data.frame} structure. For more details please refer the iris dataset.
#' \tabular{rrrrl}{
#'   \strong{Sepal.Length} \tab \strong{Sepal.Width} \tab \strong{Petal.Length} \tab \strong{Petal.Width} \tab \strong{Species} \cr
#'   5.1 \tab 3.5 \tab 1.4 \tab 0.2 \tab setosa\cr
#'   4.9 \tab 3.0 \tab 1.4 \tab 0.2 \tab setosa\cr
#'   4.7 \tab 3.2 \tab 1.3 \tab 0.2 \tab setosa\cr
#'   4.6 \tab 3.1 \tab 1.5 \tab 0.2 \tab setosa\cr
#'   5.0 \tab 3.6 \tab 1.4 \tab 0.2 \tab setosa\cr
#'   5.4 \tab 3.9 \tab 1.7 \tab 0.4 \tab setosa
#' }
#' @param pars  A \code{data.frame} object that stores your table 1 attributes.
#' \tabular{llllrll}{
#'   \strong{Mean.Sd.} \tab \strong{Median.IQR.} \tab \strong{Count.Pct.} \tab \strong{Missing.Pct.} \tab \strong{Order} \tab \strong{Parameter.name.to.display} \tab \strong{Parameters} \cr
#'    TRUE \tab FALSE \tab  TRUE \tab FALSE \tab 5 \tab Sex            \tab Sex                       \cr
#'    TRUE \tab  TRUE \tab FALSE \tab FALSE \tab 2 \tab Age            \tab Age                       \cr
#'    TRUE \tab  TRUE \tab FALSE \tab  TRUE \tab 3 \tab ALT            \tab Alt_LISResultNumericResult\cr
#'    TRUE \tab  TRUE \tab FALSE \tab  TRUE \tab 4 \tab AST            \tab Ast_LISResultNumericResult\cr
#'    TRUE \tab  TRUE \tab FALSE \tab  TRUE \tab 1 \tab FIB 4          \tab FIB_4                     \cr
#'   FALSE \tab FALSE \tab  TRUE \tab  TRUE \tab 6 \tab HBeAg positive \tab HBeAg_Test_result_numeric
#' }
#' @param All_group a \code{logical} variable; \code{TRUE} = need whole cohort information; \code{FALSE} = no need whole cohort information.
#' @param By_group a \code{logical} variable; \code{TRUE} = compare information by a factor variable; \code{FALSE} = do not compare information by a factor variable.
#' @param group_var \code{optional} string; contains your grouping variable name. \code{group_var} should contain one element only.
#' @param unnest a \code{logical} variable; \code{TRUE}=output a clean dataset of \code{nested tibble} form; \code{TRUE}=output a \code{list} with nested list (if \code{By_group==TRUE}).
#' @param par.name a \code{character} vector which stores your parameter name in your cohort dataset.
#' @param mean.sd.dp a \code{numeric} variable, number of decimal places to display. For \code{mean_sd} only.
#' @param mean.sd.p1 a \code{string} variable, the separator appeared between mean and sd. i.e. \code{<mean><p1><sd><p2>}. For \code{mean_sd} only.
#' @param mean.sd.p2 a \code{string} variable, the separator appeared after sd. i.e. \code{<mean><p1><sd><p2>}. For \code{mean_sd} only.
#' @param median.iqr.dp a \code{numeric} variable, number of decimal places to display.For \code{median_iqr} only.
#' @param median.iqr.p1 a \code{string} variable, the separator appeared between median and Q1. i.e. \code{<median><p1><iqr><p2>}.For \code{median_iqr} only.
#' @param median.iqr.p2 a \code{string} variable, the separator appeared between Q1 and Q3. i.e. \code{<median><p1><Q1><p2><Q3><p3>}.For \code{median_iqr} only.
#' @param median.iqr.p3 a \code{string} variable, the separator appeared after Q3. i.e. \code{<median><p1><Q1><p2><Q3><p3>}.For \code{median_iqr} only.
#' @param count.pct.dp a \code{numeric} variable, number of decimal places to display.For \code{count_pct} only.
#' @param count.pct.p1 a \code{string} variable, the separator appeared between count and pct. i.e. \code{<count><p1><pct><p2>}.For \code{count_pct} only.
#' @param count.pct.p2 a \code{string} variable, the separator appeared after pct. i.e. \code{<count><p1><pct><p2>}.For \code{count_pct} only.
#' @param missing.pct.dp a \code{numeric} variable, number of decimal places to display.For \code{missing_pct} only.
#' @param missing.pct.p1 a \code{string} variable, the separator appeared between missing and pct. i.e. \code{<missing><p1><pct><p2>}.For \code{missing_pct} only.
#' @param missing.pct.p2 a \code{string} variable, the separator appeared after pct. i.e. \code{<missing><p1><pct><p2>}.For \code{missing_pct} only.
#' @examples \dontrun{
#' # d<-dat #generated from user
#' # p<-par #generated from user
#' # All_group<-TRUE
#' # By_group<_TRUE
#' # group_var="Study_Design"
#' # par.name<-p$Parameters
#' # msdp<-2
#' # msp1<-"±" #the pm sign direct copy
#' # msp2<-""
#' # midp<-2
#' # mip1<-"["
#' # mip2<-","
#' # mip3<-"]"
#' # cpdp<-2
#' # cpp1<-"("
#' # cpp2<-"%)"
#' # mpdp<-2
#' # mpp1<-","
#' # mpp2<-"%"
#' #
#' # Table1(d,p,All_group,By_group,group_var=NULL,#data.split
#' # par.name,#get.stat.par
#' # msdp,msp1,msp2,#mean_sd
#' # midp,mip1,mip2,mip3,#median_iqr
#' # cpdp,cpp1,cpp2,#count_pct
#' # mpdp,mpp1,mpp2)}
#' @export
Table1<-function(dat,pars,All_group,By_group,group_var=NULL,#data.split
                 par.name,#get.stat.par
                 mean.sd.dp,mean.sd.p1,mean.sd.p2,#mean_sd
                 median.iqr.dp,median.iqr.p1,median.iqr.p2,median.iqr.p3,#median_iqr
                 count.pct.dp,count.pct.p1,count.pct.p2,#count_pct
                 missing.pct.dp,missing.pct.p1,missing.pct.p2, #missing_pct
                 detail=FALSE
){
  d<-data.split(dat,par.name,All_group,By_group,group_var,1)
  p<-get.stat.par(pars,par.name)
  stat.mean.sd<-mean_sd(d,as.vector(p[["Mean.Sd."]]),mean.sd.dp,mean.sd.p1,mean.sd.p2)
  stat.median.iqr<-median_iqr(d,as.vector(p[["Median.IQR."]]),median.iqr.dp,median.iqr.p1,median.iqr.p2,median.iqr.p3)
  stat.count.pct<-count_pct(d,as.vector(p[["Count.Pct."]]),count.pct.dp,count.pct.p1,count.pct.p2)
  stat.missing.pct<-missing_pct(d,as.vector(p[["Missing.Pct."]]),missing.pct.dp,missing.pct.p1,missing.pct.p2)
  tab<-lists.merge(c(stat.mean.sd,stat.median.iqr,stat.count.pct,stat.missing.pct))
  Table1.format(tab,pars,detail)

}

lists.merge<-function(res.vec){
  cond<-res.vec%>%map(.,class)%>%lapply(.,`%in%`,"data.frame")%>%map_dbl(isTRUE)%>%as.logical
  bind_rows(res.vec[cond]%>%bind_rows(.,.id="Method"),res.vec[!cond]%>%unlist(recursive=FALSE)%>%bind_rows(.,.id="Method"))
}

Table1.format<-function(tab,par,detail=FALSE){
  t<-tab%>%spread(Method,Value)%>%left_join(.,par,by="Parameters")%>%
    relocate(any_of(c("Parameter.name.to.display","levels")))%>%
    arrange(Order)%>%
    select(which(sapply(., is.character)))
  t[,"Parameter.name.to.display"]<-ifelse(grepl("Missing",t[,"Statistics"]),t[,"Statistics"],t[,"Parameter.name.to.display"])
  if(!detail) t%>%select(-c("Parameters","Statistics")) else t
}
