package com.wilkom.dockerdemo.exception;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;
import org.springframework.http.HttpStatus;

@Data
@AllArgsConstructor
public class ExceptionResponse {

  private HttpStatus status;
  private int code;
  private String message;
  private String description;

  @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
  private LocalDateTime timestamp;

  public ExceptionResponse() {
    this.timestamp = LocalDateTime.now();
  }

  public ExceptionResponse(HttpStatus status) {
    this();
    this.status = status;
    this.message = "An error occured";
    this.code = status.value();
  }

  public ExceptionResponse(String message) {
    this();
    this.message = message;
    this.status = HttpStatus.INTERNAL_SERVER_ERROR;
    this.code = HttpStatus.INTERNAL_SERVER_ERROR.value();
  }

  public ExceptionResponse(HttpStatus status, String message, Throwable ex) {
    this();
    this.status = status;
    this.message = message;
    this.description = ex.getLocalizedMessage();
    this.code = status.value();
  }
}
