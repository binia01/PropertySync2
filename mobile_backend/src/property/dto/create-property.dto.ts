import { IsString, IsNotEmpty, IsInt } from 'class-validator';

export class CreatePropertyDto {
  @IsNotEmpty()
  @IsString()
  title: string;

  @IsNotEmpty()
  @IsString()
  description: string;

  @IsNotEmpty()
  @IsInt()
  price: number;

  @IsNotEmpty()
  @IsString()
  location: string;

  @IsNotEmpty()
  @IsInt()
  beds: number;

  @IsNotEmpty()
  @IsInt()
  baths: number;

  @IsNotEmpty()
  @IsInt()
  area: number;
}