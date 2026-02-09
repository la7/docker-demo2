package com.wilkom.dockerdemo.exception;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalControllerExceptionHandler {

  @ExceptionHandler({ DataIntegrityViolationException.class })
  @ResponseStatus(value = HttpStatus.CONFLICT)
  public ExceptionResponse handleDIVException(
    DataIntegrityViolationException e
  ) {
    return new ExceptionResponse(
      HttpStatus.CONFLICT,
      "Data integrity error.",
      e
    );
  }

  @ExceptionHandler({ Exception.class })
  @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
  public ExceptionResponse handleException(Exception e) {
    return new ExceptionResponse(
      HttpStatus.INTERNAL_SERVER_ERROR,
      e.getLocalizedMessage(),
      e
    );
  }
}
