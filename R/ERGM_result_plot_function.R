#' @title ERGM_result_plot
#'
#' @description creates plot for ERGM results
#' @param ergm.fit ERGM object
#' @param custom_var_names Variable names
#' @param plot_title Plot title
#' @param y_axis_lab TRUE/FALSE - do you want the y-axis labels present. FALSE useful for panel plots. Default TRUE
#' @export
#' @return plot

ERGM_result_plot<-function(ergm.fit,custom_var_names,plot_title,y_axis_lab=TRUE){
  est <- cbind(round(cbind(stats::coef(ergm.fit), stats::confint(ergm.fit)),
                     3))
  colnames(est) <- c("ergm", "ergm.low", "ergm.high")

  rownames(est) <- custom_var_names
  #custom_var_names<-rownames(est)
  coef_df <- data.frame()
  est<-as.data.frame(est,stringsAsFactors = FALSE)
  for (i in 1:length(custom_var_names)) {
    temp <- data.frame(var = custom_var_names[i],
                       coef = est$ergm[i], low = est$ergm.low[i],
                       high = est$ergm.high[i])
    coef_df <- rbind(coef_df, temp)
  }
  coef_df$var <- factor(coef_df$var, levels = unique(coef_df$var))
  coef_df$colour<-1:length(coef_df$var)
  for (i in 1:length(coef_df$var)){
    if (coef_df[i,]$low < 0&coef_df[i,]$high>0){
      coef_df[i,]$colour<-"dodgerblue4"
    } else if (coef_df[i,]$low>0&coef_df[i,]$high>0){
      coef_df[i,]$colour<-"red"
    }else if (coef_df[i,]$low<0&coef_df[i,]$high<0){
      coef_df[i,]$colour<-"red"
    } else {
      coef_df[i,]$colour<-"white"
    }
  }

  if (y_axis_lab==FALSE){
    p <- ggplot2::ggplot(coef_df, ggplot2::aes(x = coef_df$var)) +
      ggplot2::geom_pointrange(ggplot2::aes(y = coef_df$coef,
                                            ymin = coef_df$low,
                                            ymax = coef_df$high),
                               colour = coef_df$colour)+
      ggplot2::theme_bw() +
      ggplot2::coord_flip() +
      ggplot2::scale_x_discrete(limits=rev(coef_df$var))+
      ggplot2::geom_hline(yintercept = 0,lty = 2) +
      ggplot2::xlab("Variable") +
      ggplot2::ylab("Coefficient") +
      ggplot2::theme_bw() +
      ggplot2::theme(axis.text = ggplot2::element_text(size = 12),
                     axis.title = ggplot2::element_text(size = 14,
                                                        face = "bold"),
                     axis.text.y=ggplot2::element_blank(),axis.title.y=ggplot2::element_blank())+
      ggplot2::ggtitle(plot_title)
  }else{
    p<- ggplot2::ggplot(coef_df, ggplot2::aes(x = coef_df$var)) +
      ggplot2::geom_pointrange(ggplot2::aes(y = coef_df$coef,
                                            ymin = coef_df$low,
                                            ymax = coef_df$high),
                               colour = coef_df$colour)+
      ggplot2::theme_bw() +
      ggplot2::coord_flip() +
      ggplot2::scale_x_discrete(limits=rev(coef_df$var))+
      ggplot2::geom_hline(yintercept = 0,lty = 2) +
      ggplot2::xlab("Variable") +
      ggplot2::ylab("Coefficient") +
      ggplot2::theme_bw() +
      ggplot2::theme(axis.text = ggplot2::element_text(size = 12),
                     axis.title = ggplot2::element_text(size = 14,
                                                        face = "bold")
      )+
      ggplot2::ggtitle(plot_title)
  }

  return(p)
}
