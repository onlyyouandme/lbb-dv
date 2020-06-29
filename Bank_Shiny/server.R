function(input, output){

# balance plot ----

    
      output$balancePlot <- renderPlotly(
      {
        #transform data
        balancex <- bankm %>% 
          select(age_grouping, job, balance) %>%
          filter(balance >= 1) %>% 
          arrange(desc(balance)) %>% 
          group_by(age_grouping, job) %>% 
          summarise(balance_mean = mean(balance)) %>% 
          ungroup() %>% 
          arrange(desc(balance_mean)) %>% 
          mutate(text = paste(age_grouping,":",round(balance_mean,2),"$"))
        
        #visualize
        plot_balance <- ggplot(balancex, aes(x = balance_mean, y = job, text = text))+
          geom_col(aes(fill = age_grouping))+ 
          labs(x = "Job", y = "Balance",title = "Total Balance of Job based on Age Grouping")+
          theme(legend.position = "none")+
          scale_x_continuous(labels = unit_format(unit = "$"))
          
        
        #add interactivy
        ggplotly(plot_balance, tooltip = "text") %>% 
          config(displayModeBar = F)
      }
    )
    

# duration plot ----

    output$durationPlot <- renderPlotly(
      {
        duration_job <- bankm %>% 
          select(job, month, duration, default) %>% 
          filter(job == input$selectCat) %>% 
          group_by(month, job, default, duration) %>% 
          summarise(duration = mean(duration)) %>%
          arrange(desc(duration)) %>% 
          ungroup() %>% 
          mutate(text1 = paste(job,";",month))
        
        duration_job_plot <- ggplot(bankm, aes(x = month_code, y = duration))+
          geom_point(aes(color=default))+
          geom_line(aes(color=default))+
          facet_wrap(~default, ncol=2, scales = "free")+
          labs(x = "Number of Month", y = "Call Duration (s)", title = "Duration of called based on Job")+
          theme(legend.position = "none")
        
        ggplotly(duration_job_plot, tooltip = "text1")%>%
          config(displayModeBar = F)
      }
    )   
}