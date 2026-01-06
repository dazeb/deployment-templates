import config from '@payload-config'
import { RootPage, generatePageMetadata } from '@payloadcms/next/views'
import { importMap } from '../importMap'

type Args = {
  params: Promise<{
    segments: string[]
  }>
  searchParams: Promise<{
    [key: string]: string | string[]
  }>
}

export const generateMetadata = (args: Args) =>
  generatePageMetadata({ config, ...args })

const Page = (args: Args) =>
  RootPage({ config, importMap, ...args })

export default Page
