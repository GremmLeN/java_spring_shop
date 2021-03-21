package com.geekbrains.geekspring.aspects;


import com.geekbrains.geekspring.entities.Order;
import com.geekbrains.geekspring.entities.Product;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;


@Aspect
@Component
public class AspectLogger {

    Logger log = Logger.getLogger("file");

    @After("execution(public * com.geekbrains.geekspring.controllers.ProductController.*(..))")
    public void callProductController() {
        log.info("Call prodcut controller");
    }

    @After("execution(public * com.geekbrains.geekspring.services.ProductService.saveProduct(..))")
    public void saveProduct(JoinPoint joinPoint) {
        Object[] values = joinPoint.getArgs();
        Product product = (Product) values[0];

        log.info("Создан новый товар" + product.getTitle() + "id: " + product.getId());

    }

    @After("execution(public * com.geekbrains.geekspring.services.OrderService.saveOrder(..))")
    public void makeOrder(JoinPoint joinPoint) {
        Object[] values = joinPoint.getArgs();
        Order order = new Order();

        for (int i = 0; i < values.length; i++) {
            if (values[i] instanceof Order ) {
                order = (Order) values[i];
            }
        }
        log.info("Пользовалель" + order.getUser().getUserName() + "создал заказ" + order.getId());
    }
}
